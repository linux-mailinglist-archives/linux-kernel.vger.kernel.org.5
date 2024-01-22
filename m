Return-Path: <linux-kernel+bounces-33288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2AB8367FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26191C20C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714295C8E4;
	Mon, 22 Jan 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQK7aWnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAB40C13;
	Mon, 22 Jan 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935622; cv=none; b=tysE53y2uqMbu+fie79YmekZZVsFGu6aLFxdpBAvJoops++dInYlwnZk/ycH4SzKd7GouNjeyawhK2TQYFBCUf6WvurB4HXOCtHL+oZwWkqQFOtoWlBdueE6hCZzK9hAw8Atq8pDUvZX6pBHPOc5p5mW8hlKkw2FBoMgSmRSQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935622; c=relaxed/simple;
	bh=ziCgN18ZBJKgFtWmWXYcTNGfWO2DoZ1XDQaXC3PcFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQLAKXpv/PaVn/wtV4Oo5o9N8kD8zq64YsGvwEmZOVSupplbSnJPb/0S+qjmuntee2re6j/QxxXnwY4ePXOLMa8SNRwqvZQxgO7eobT68r6AKQxOv8oTeIN3df5TJgS3qYut1dCD23LR0aDxdFtXZBpPPSJybkF73Iu/ClMwVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQK7aWnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D5C43390;
	Mon, 22 Jan 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935622;
	bh=ziCgN18ZBJKgFtWmWXYcTNGfWO2DoZ1XDQaXC3PcFpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQK7aWnzjZzdFVGzDp+JNdBtFy5E8iIU+z4fMMRPepQ0bBmSkMOxZ4WaOiGrouQJm
	 75pPS4Le4ZKUwSZEv+GubI3qgjC0c6c0tNDGlkmAsy2LyYc4Scw4NV4nGJhhriS3aE
	 Mg7aDpdXYnyMeqXQ1JWv2Dx6vO/AtFIDREpwVYzz+5DXhF2i2B5H0BWYrLijvn3thq
	 5zBTUbT8PcicdUm5kOzXxRroJh++3wFUSQERhwAaaQiYe3VgZ1MDuQrDA08A8zaU9S
	 SMnXuP4fZ9u6nTc8Sasju/VrY8Q4xn81Orue0v6j2ik1SpzqVuJR1TxTl39FejJ1Fe
	 /Zc6IM/4BS+Vw==
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
	hamza.mahfooz@amd.com,
	mario.limonciello@amd.com,
	wenjing.liu@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 66/88] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 09:51:39 -0500
Message-ID: <20240122145608.990137-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index e2a3aa8812df..811474f4419b 100644
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


